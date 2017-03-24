class ApplicationMailer < ActionMailer::Base
  include ApplicationHelper
  default from: 'lmsbotree@gmail.com'
  layout 'mailer'
end
