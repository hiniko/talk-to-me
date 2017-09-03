class SayService
  include AASM 

  attr_reader :path, :voice_options

  aasm do 
    state :init, initial: true  
    state :error, :ready, :talking, :waiting

    after_all_transitions :notify

    event :run, before: :locate_say do 
      error do |e|
        puts "Failed: #{e}"
      end
      transitions from: :init, to: :ready
    end

    event :talk do 
      transitions from: :ready, to: :talking
    end

    event :pause do 
      transitions from: :talking, to: :waiting
    end

    event :reset do 
      transitions from: [:init, :waiting], to: :ready
    end

  end

   def say(voice, message)
     talk 
     `#{@wrapper_path} #{@path} -v #{voice} "#{message.inspect}"`
     wait 1
     reset
   end

   def locate_say
     # The wrapper will reattach the say process to the user namespace where
     # it can then access the audio system to make the command work 
     @wrapper_path = Rails.root.join 'vendor', 'reattach-to-user-namespace' 
     # find bin path
     @path ||= `which say`.chop
     raise "Say not found ('#{@path}')" unless File.exist? @path 
     Rails.logger.info "Found say binary at '#{path}'"
     # Get available voices
     raw_options = `#{@wrapper_path} #{@path} -v "?"`.split("\n").map {|line| line.split(/\s\s+/)}
     @voice_options = [] 
     raw_options.each do |option|
        @voice_options << { voice: option[0], locale: option[1], description: option[2] }
     end
     Rails.logger.info "There are #{@voice_options.size} voices available" 
   end

   def wait(time)
      pause
      sleep time 
   end

   def on_notify(&block)
     @notify_block = block  
   end

   def notify
     if @notify_block.is_a? Proc 
       @notify_block.call aasm.to_state, aasm.current_event
     end
   end
end
