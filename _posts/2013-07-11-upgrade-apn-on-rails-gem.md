---
title: Upgrade natescherer:apn_on_rails to new version of PRX:apn_on_rails gem
published: true
date: 2013-07-11 21:33
tags:
- rails
category:
- en
comments: true

---
<a href="{% link _posts/2013-07-11-upgrade-apn-on-rails-gem.md %}" class="lang-btn lang-current">EN</a>
<a href="{% link _posts/2013-07-10-upgrade-apn-on-rails-gem.md %}" class="lang-btn">TW</a>

### Major changes
* send_notifications method in PRX's did not accept an array of notifications as paramter. It sends all unsent notifications.
* Add `APN::App`. Put cert in database and allow you to send to multiple iOS apps with 1 rails app
* Add `APN::Group`. Allow you to send group notifications. (But it still send one by one to Apple APN server)


### Steps
#### Edit `Gemfile`

    gem 'apn_on_rails'

And

    bundle install

#### Migrateions

    rails generate apn_on_rails:install

* If it complains about some migrations have a same name, rename the old migrations and run again, delete the duplicated and rename back.
* README says that maigration 002 `create_apn_notifications` was modified by hand and may cause a problem. See [Upgrade Notes](https://github.com/PRX/apn_on_rails/blob/master/README.textile#upgrade-notes) if needed.

And

    rake db:migrate

#### Create first APN::App and move cert into database
Copy the content of `/config/apple_push_notification_development.pem` and `apple_push_notification_production` and save into APN::app#apn_dev_cert and APN::app#apn_prod_cert. [See this post](http://stackoverflow.com/questions/11533529/uninitialized-constant-apnapprails-env). (but you need to reslove the massive-assignment problem before running it on rails 3.2)


#### Modifiy APN::Notification.send_notifications and let it accept an array of notificaitons
Because that the natescherer:apn_on_rails folk accepts an array of notificaitons to send. But the PRX one are not. So I added it by hand.

Create `config/initializers/apn_notification_reopen.rb`

    class APN::Notification

      # ...

      def self.send_notifications(notifications = APN::Notification.where("sent_at is null"))
        app_ids = notifications.map {|n| n.device.app_id }.uniq
        app_ids.each do |app_id|
          begin
            if (app = APN::App.where(:id => app_id).first)
              the_cert = Rails.env.production? ? app.apn_prod_cert : app.apn_dev_cert
              APN::Connection.open_for_delivery({:cert => the_cert}) do |conn, sock|
                unsent_notifications = notifications.select {|n| n.device.app_id == app_id }
                unsent_notifications.each do |noty|
                  conn.write(noty.message_for_sending)
                  noty.sent_at = Time.now
                  noty.save
                end
              end
            end
          rescue Exception => e
            STDERR.puts e.message
            raise e
          end
        end

      end
    end


### Troubleshooting
#### NameError: uninitialized constant APN::App::RAILS_ENV

Add following line in `config/environment.rb`:

    APN::App::RAILS_ENV = Rails.env


#### Errno::ENOENT: No such file or directory - /config/apple_push_notification_development.pem

run:

    script/rails generate configatron:install

It will generate configatron files. Edit `config/configatron/defaults.rb` add:

    configatron.apn.cert = ''
