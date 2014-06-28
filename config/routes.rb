Flow::Application.routes.draw do
  post 'couponcode', to: 'payments#couponcode'
  post 'iframe',     to: 'payments#iframe'
end
