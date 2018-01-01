require 'capybara/rspec'
require 'capybara/rails'
Capybara.javascript_driver = :headless_chrome

#Then we’ll want register the selenium webdriver wth the chrome browser
require "selenium/webdriver"
driver_name = :selenium
browser_name = :chrome
options = {}

Capybara.register_driver driver_name do |app|
  driver_options = {browser: browser_name}.merge(options)
  Capybara::Selenium::Driver.new(app, driver_options)
end

#And register the chrome browse as a webdriver.
driver_name = :chrome
browser_name = :chrome
options = {}
screen_size = [1920, 1080]

Capybara.register_driver driver_name do |app|
  driver_options = {browser: browser_name}.merge(options)
  Capybara::Selenium::Driver.new(app, driver_options).tap do |driver|
    driver.browser.manage.window.size = Selenium::WebDriver::Dimension.new(*screen_size)
  end
end

#And finally, register the headless web driver:

driver_name = :headless_chrome
browser_name = :chrome
driver_capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    # see
    # https://robots.thoughtbot.com/headless-feature-specs-with-chrome
    # https://developers.google.com/web/updates/2017/04/headless-chrome
    chromeOptions: {
      args: %w(headless disable-gpu no-sandbox),
      # https://github.com/heroku/heroku-buildpack-google-chrome#selenium
      binary:  ENV.fetch('GOOGLE_CHROME_SHIM', nil)
    }.reject { |_, v| v.nil? }
  )

Capybara.register_driver driver_name do |app|
  Capybara::Selenium::Driver.new(
    app,
    browser: browser_name,
    desired_capabilities: driver_capabilities
  )
end
