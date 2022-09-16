Rails.application.routes.draw do
  with_options controller: :errors do
    match '/404', action: :not_found, via: :all
    match '/422', action: :unprocessable_entity, via: :all
    match '/500', action: :internal_server_error, via: :all
  end
end
