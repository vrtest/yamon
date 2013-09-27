Yamon::Application.routes.draw do

  match '/current_alerts/delete_3h'  => 'current_alerts#delete_3h'

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

  match 'login/:action(/:id)' => 'login#index'
  match 'dispo_stats(/:dateFrom(/:dateTo))' => 'dispo_stats#index'
  match '/' => 'alerts#index'
  match '/alerts/link_to_report' => 'alerts#link_to_report'
  match '/reports/untag' => 'reports#untag'
  match '/reports/tag' => 'reports#tag'
  match '/services/tag' => 'services#tag'
  match '/services/untag' => 'services#untag'
  match '/hosts/tag' => 'hosts#tag'
  match '/hosts/untag' => 'hosts#untag'

end
