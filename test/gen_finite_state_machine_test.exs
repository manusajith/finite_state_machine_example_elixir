defmodule GenFiniteStateMachineTest do
  use ExUnit.Case
  
  doctest GenFiniteStateMachine

  test "[:staring] it successfully consume the string 's'" do
    fsm = GenFiniteStateMachine.start_link
    assert GenFiniteStateMachine.consume_s(fsm) == :got_s
  end

  test "[:starting] it successfully consume string other than 's'" do
    fsm = GenFiniteStateMachine.start_link
    assert GenFiniteStateMachine.consume_not_s(fsm) == :starting
  end

  test "it successfully consumes the string sips" do
    fsm = GenFiniteStateMachine.start_link
    GenFiniteStateMachine.consume_s(fsm)
    GenFiniteStateMachine.consume_i(fsm)
    GenFiniteStateMachine.consume_p(fsm)
    assert GenFiniteStateMachine.consume_s(fsm) === :got_sips
  end

  test "it successfully consumes without a match" do
    fsm = GenFiniteStateMachine.start_link
    GenFiniteStateMachine.consume_s(fsm)
    GenFiniteStateMachine.consume_i(fsm)
    GenFiniteStateMachine.consume_p(fsm)
    assert GenFiniteStateMachine.consume_not_s(fsm) === :starting
  end

  test "it cant fall out of the `got_sips` state" do
    fsm = GenFiniteStateMachine.start_link
    GenFiniteStateMachine.consume_s(fsm)
    GenFiniteStateMachine.consume_i(fsm)
    GenFiniteStateMachine.consume_p(fsm)
    GenFiniteStateMachine.consume_s(fsm)
    assert GenFiniteStateMachine.consume_i(fsm) === :got_sips
  end

end
