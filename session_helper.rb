module SessionHelper
  def remember_as key, val
    session[key] = val
  end

  def recall key
    p '-----'
    pp session
    session[key]
  end

  def recall_or_init key, val
    session[key] = val if session[key].nil?
    session[key]
  end

  def forget key
    session[key] = nil
  end
end

