Capybara.run_server = true
Capybara.server_port = 9887

Before('@selenium') do
  switch_session('selenium')
end

