class Occasion  < CustomerData
  belongs_to :location
  belongs_to :occasion_type
  
  validates_presence_of     :name
  validates_presence_of     :state  

  def repeat_weekly(occasion, repeat_until)
  
    while occasion.start_time.advance(:weeks => 1) < repeat_until
      recurring_occasion = occasion.clone
      recurring_occasion.start_time = occasion.start_time.advance(:weeks => 1)
      
      recurring_occasion.save
      occasion = recurring_occasion
    end
  end

  def getOptionsForSelectList(method)
   case method
     when :state
       @options = {
         'luonnos' => 10,
         'valmis' => 20,
         'peruttu' => 30
       }
      when :repeat
       @options = {
         'ei toistoa' => 0,
         'kerran viikossa' => 10,
         #'kerran kuukaudessa' => 20,
         #'kerran vuodessa' => 30
       }
   when :inform_changes
      @options = {
        'ei' => 0,
        'kyllä' => 1
      }
   end
  end

  def self.inform_yes
    1
  end

  def self.state_ready
    20
  end
    

  def ready?
    state == 20
  end

  def monthname
    @monthname = %w{tammi helmi maalis huhti touko kesä heinä elo syys loka marras joulu}
  end

   def start_date_month_str
 	    month_only_str(start_time)
 	  end
 
  def start_date_only_str
    date_only_str(start_time)
  end

  def start_time_only_str
    time_only_str(start_time)
  end

  def start_date_week_str
    week_only_str(start_time)
  end
 
 private
  def month_only_str(time)
 	    unless time.nil?
 	      time.strftime("%m")
 	    end
 	  end
   def date_only_str(time)
    unless time.nil?
      time.strftime("%d.%m.%y")
    end
  end

  def time_only_str(time)
    unless time.nil?
      time.strftime("%H:%M")
    end
  end

  def week_only_str(time)
    unless time.nil?
      time.strftime("%W")
    end
  end
end
