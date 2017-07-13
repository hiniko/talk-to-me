class SayService
  include AASM 

  aasm do 
    state :init, initial: true  
    state :error, :ready, :talking, :waiting

    event :run do 
      transitions from: :init, to: [:ready, :error]
    end

    event :ready do 
      transitions from: [:talking, :waiting], to: :ready
    end

    event :talk do 
      transitions from: :ready, to: :talking
    end

    event :wait do 
      transitions from: [:ready, :talking], to: :waiting
    end

    after_all_transitions :log_status_change

  end

   def log_status_change
         puts "changing from #{aasm.from_state} to #{aasm.to_state} (event: #{aasm.current_event})"
   end

end
