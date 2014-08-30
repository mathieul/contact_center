Rails.application.routes.draw do

  mount ContactCenterBackend::Engine => "/contact_center_backend"
end
