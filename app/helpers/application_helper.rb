module ApplicationHelper



  def color (index)
    case index
     when 1
       return '#cf4c64'
     when 2
       return '#9f1c34'
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
