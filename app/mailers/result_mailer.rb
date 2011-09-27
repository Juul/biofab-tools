class ResultMailer < ActionMailer::Base
  default :from => "noreply@biofab.org"


 
  def foo
    sleep 15
    time = Time.now
    mail(:to => "marcjc@gmail.com", :subject => "BIOFAB Test #{time}")
  end

end
