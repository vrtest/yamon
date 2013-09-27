namespace :db do
  #hostnameList=['tomato','orange','banana']
  serviceNameList=['http','ftp','ssh']
  tnow=Time.now
  desc "This loads the development data."
  task :add_test_data => :environment do

  puts "Add Hosts ..."
  h1 = Host.create(:name => 'tomato')
  h2 = Host.create(:name => 'orange')
  h3 = Host.create(:name => 'banana')
  hostList=[h1.id, h2.id, h3.id]

  puts "Add reports ..."
  r1 = Report.create(:label => 'Internet Failure', :description => 'Internet is broken !')
  r2 = Report.create(:label => 'Server power failure', :description => 'The server power cable has been unplugged by Robert !')
  r3 = Report.create(:label => 'Delivery', :select_priority => 10 )

  puts "Add reports tags ..."
  rt1 = Reporttag.create(:name => 'Planned operation', :description => 'Delivery, ...', :css_classes => 'PlannedAndExcluded')
  ReportsReporttag.create(:reporttag_id => rt1.id, :report_id => r3.id)

  hostList.each { |h|
    puts "Add service #{h} ..."
    s=Service.new()
    s.host_id = h
    s.name = serviceNameList.sample
    s.save

    printf "Add alerts for #{h} ..."
    i=300000
    while (i > 0 )
      printf '.'
      d=60*(1+rand(5))*(1+rand(20))
      report=nil
      report=r1.id if (i>100000 && i<130000)
      report=r2.id if (i>200000 && i<230000)
      report=r3.id if (i>290000)
      alert=Alert.create(
        :service_id => s.id,
	:host_id => h,
        :date_start => tnow-i,
        :date_end => tnow-i+d,
        :check_status => 2,
        :service_output => 'timeout ...',
        :service_perfdata => '',
        :duration => d,
        :report_id => report
      )
      i = i - 600*(6+rand(10))
    end
    printf "\n"
  }
  
  end


  desc "This remove the development data. (not implemented yet)"
  task :remove_test_data => :environment do
    #TODO
  end
  

end
