class SayServiceTest< ActiveSupport::TestCase

  setup do 
    @ss = SayService.new
  end

  test "Service cannot run before checking location of say command" do 
    assert_equal @ss.aasm.current_state, :init

    assert_raises AASM::InvalidTransition do 
      @ss.talk "Throws and error"
    end
  end

  # Weak test, as failure condition not defined. Future Sherman's problem
  test "Locates local say command" do 
    @ss.run
    refute_empty @ss.path 
  end

end
