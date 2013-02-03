SERVICES_PATH='data/services'

module App
  def dispatch_service svc, stg
    stg_overide = recall_overide svc 

    stg_overide = stg if stg_overide.nil?

    p "-----"
    p "gng to fetch #{svc}/#{stg_overide}"

    if service_exists? svc, stg_overide
      fetch_service svc, stg_overide
    else
      remember_as 'failedcall', [svc, stg_overide]
      erb :service_unavailable
    end
  end

  def service_exists? svc, stg
    File.exist? "#{SERVICES_PATH}/#{svc}_#{stg}.xml"
  end

  def fetch_service svc, stg
    File.read("#{SERVICES_PATH}/#{svc}_#{stg}.xml")
  end

  def set_overide svc, stg
    so = recall_or_init 'send_overides', {}
    so[svc] = stg
  end

  def forget_overide svc
    so = recall_or_init 'send_overides', {}
    so[svc] = nil
  end

  def recall_overide svc
    so = recall_or_init 'send_overides', {}
    so[svc]
  end
end

