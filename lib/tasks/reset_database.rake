namespace :db do
  task bs: [:drop, :create, :migrate ]
end
