module ApplicationHelper
  
  
  
  def color (index)
    case index
     when 1
       return '#69D2E7'
     when 2
       return '#A7DBD8'
     when 3
        return '#E0E4CC'
     when 4
        return '#F38630'
     else
        return '#F38630'
     end
  end
  
  
  def cssClassActive (contName)
    
    if( controller_name == contName)
       return "class=active"
     end
      return ''
  end
  
end
