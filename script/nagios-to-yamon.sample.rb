#!/usr/bin/ruby -w
#This script is used to insert services alerts from nagios to yamon
#Input parameters:
# ** service
#$HOSTNAME$ "$SERVICEDESC$" $SERVICESTATEID$ $LASTSERVICECHECK$ $SERVICESTATETYPE$ "$SERVICEOUTPUT$" "$SERVICEPERFDATA$"
#./nagios-to-yamon.sample.rb host01 service01 2 `date +%s` HARD error
#./nagios-to-yamon.sample.rb host01 service01 0 `date +%s` HARD error
#
# ** host
#$HOSTNAME$ 0 $HOSTSTATEID$ $LASTHOSTCHECK$ $HOSTSTATETYPE$ $HOSTOUTPUT$

require 'rubygems'
gem 'dbi'
require 'dbi'

class NagiosToYamon

  STATE_OK = 0
  CHECK_STATUS = 2
  HOST_ONLY_SERVICE_KEY = "0"

  SQL_INS_CA = "insert into current_alerts (hostname,description,check_status,check_date,service_output,service_perfdata,created_at,updated_at) values (?,?,?,?,?,?,?,?)"
  SQL_SEL_CA = "select hostname,description,check_status,check_date,service_output,service_perfdata,id from current_alerts where hostname=? and description=?"
  SQL_SEL_CA_HOST = "select hostname,description,check_status,check_date,service_output,service_perfdata,id from current_alerts where hostname=? and description is null"
  SQL_SEL_HOST = "select id from hosts where name=?"
  SQL_INS_HOST = "insert into hosts (name, created_at,updated_at) values (?,?,?)"
  SQL_SEL_SERV = "select id from services where host_id=? and name=?"
  SQL_INS_SERV = "insert into services (name, host_id, created_at, updated_at) values (?,?,?,?)"
  SQL_INS_ALERT = "insert into alerts (host_id,service_id,date_start,date_end,duration,check_status,service_output,service_perfdata) values (?,?,?,?,?,?,?,?)"
  SQL_DEL_CA = "delete from current_alerts where id=?"

  def initialize(hostname, service, state, lastcheck, statetype, output, perfdata)

    @input = {}
    @input['hostname'] = hostname
    @input['service'] = service
    @input['state'] = state.to_i
    @input['lastcheck'] = lastcheck.to_i
    @input['statetype'] = statetype #"HARD" or "SOFT"
    @input['output'] = output
    @input['perfdata'] = perfdata

    @host_only = false

    if service == HOST_ONLY_SERVICE_KEY
      @input['service'] = nil
      @host_only = true
    end

    @now_db = Time.now.strftime("%Y-%m-%d %H:%M:%S")

  end

  def host_only?
    @host_only == true
  end

  def init_db
    @dbh = DBI.connect("DBI:Mysql:yamon_development:localhost", "yamon", "yamon")
  end

  def close_db
    @dbh.disconnect if @dbh
  end

  def state_hard?
    @input['statetype'] == "HARD"
  end

  def set_current_alert
    if host_only?
      @current_alert = @dbh.select_one(SQL_SEL_CA_HOST, @input['hostname'])
    else
      @current_alert = @dbh.select_one(SQL_SEL_CA, @input['hostname'], @input['service'])
    end
  end

  #new alert
  def change_state_ok_to_nok
    @dbh.do(SQL_INS_CA, @input['hostname'],@input['service'],@input['state'],@input['lastcheck'],
                        @input['output'],@input['perfdata'], @now_db, @now_db)
  end

  def change_state_nok_to_ok

    #get the host id
    row = @dbh.select_one(SQL_SEL_HOST, @input['hostname'])

    #host unknown, create it
    if row.nil? then
      @dbh.do(SQL_INS_HOST, @input['hostname'],@now_db, @now_db)
      host_id = @dbh.func(:insert_id)
    else
      host_id = row[0]
    end
 
    #get the service id
    if host_only?
      service_id = nil
    else
      row = @dbh.select_one(SQL_SEL_SERV, host_id, @input['service'])

      #service unknown, create it
      if row.nil? then
        @dbh.do(SQL_INS_SERV, @input['service'], host_id, @now_db, @now_db)
        service_id = @dbh.func(:insert_id)
      else
        service_id = row[0]
      end
    end

    #insert alert row into alerts
    date_start = Time.at(@current_alert[3]).strftime("%Y-%m-%d %H:%M:%S")
    date_end = Time.at(@input['lastcheck']).strftime("%Y-%m-%d %H:%M:%S")
    duration = @input['lastcheck'] - @current_alert[3]
    @dbh.do(SQL_INS_ALERT, host_id, service_id, date_start, date_end, duration,
                           @current_alert[2], @current_alert[4], @current_alert[5])

    #delete from current
    @dbh.do(SQL_DEL_CA, @current_alert[6])

  end

  def change_state_nok_to_nok

    change_state_nok_to_ok

    #insert into current the new state
    @dbh.do(SQL_INS_CA, @input['hostname'], @input['service'], @input['state'], @input['lastcheck'],
                        @input['output'], @input['perfdata'], @now_db, @now_db)
  end

  def alert_is_ok_and_new?
    @input['state'] == STATE_OK && @current_alert.nil?
  end

  def alert_is_nok_and_new?
    @input['state'] != STATE_OK && @current_alert.nil?
  end

  def alert_is_nok_and_not_new?
    @input['state'] != STATE_OK && !@current_alert.nil? && @current_alert[CHECK_STATUS] == @input['state']
  end

  def alert_is_over?
    @input['state'] == STATE_OK && !@current_alert.nil? && @current_alert[CHECK_STATUS] != @input['state']
  end

  def alert_change_status?
    @input['state'] != STATE_OK && !@current_alert.nil? && @current_alert[CHECK_STATUS] != @input['state']
  end
end

#MAIN, THINGS START HERE

nty = NagiosToYamon.new(ARGV[0], ARGV[1], ARGV[2], ARGV[3], ARGV[4], ARGV[5], ARGV[6])

exit if !nty.state_hard? #we want hard only

begin
  nty.init_db

  #check for current alert
  nty.set_current_alert

  if nty.alert_is_ok_and_new?
    p "[OK] current is empty, nothing to do"
  elsif nty.alert_is_nok_and_new?
    p "[NOK] create new current entry"
    nty.change_state_ok_to_nok
  elsif nty.alert_is_nok_and_not_new?
    p "[NOK] already fill, nothing to do"
  elsif nty.alert_is_over?
    p "[OK] mv to done"
    nty.change_state_nok_to_ok
  elsif nty.alert_change_status?
    p "[NOK] mv to another bad status"
    nty.change_state_nok_to_nok
  else
    p "Unknow input o_O"
  end

rescue DBI::DatabaseError => e
  puts "An error occurred"
  puts "Error code: #{e.err}"
  puts "Error message: #{e.errstr}"
ensure
  nty.close_db
end
