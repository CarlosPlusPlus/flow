Flow::Application.routes.draw do
  post 'iframe', to: 'payments#iframe'
end