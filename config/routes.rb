Yamon::Application.routes.draw do

  get '/current_alerts/delete_3h'  => 'current_alerts#delete_3h'

  resources :home
  resources :hosttags
  resources :hosts
  resources :reporttags
  resources :servicetags
  resources :hosttags
  resources :reports
  resources :services
  resources :alerts
  resources :current_alerts

  match 'login/:action(/:id)' => 'login#index', via: [:get, :post]
  get 'dispo_stats(/:dateFrom(/:dateTo))' => 'dispo_stats#index'
  get '/' => 'alerts#index'
  get '/alerts/link_to_report' => 'alerts#link_to_report'
  get '/reports/untag' => 'reports#untag'
  get '/reports/tag' => 'reports#tag'
  get '/services/tag' => 'services#tag'
  get '/services/untag' => 'services#untag'
  get '/hosts/tag' => 'hosts#tag'
  get '/hosts/untag' => 'hosts#untag'

end
