#===============================================================================
# Dialogue Portraits - automatic cleanup
# - When a map event finishes, any portraits still on screen slide out, so a
#   forgotten portraitHide can't leave a face stuck there.
# - Portraits are hidden while a battle is on screen and come back after it.
# - Starting a new game or loading a save removes them immediately.
#===============================================================================
module DialoguePortraits
    module InterpreterHook
        def command_end
            if @main && @depth == 0 && DialoguePortraits::HIDE_AT_EVENT_END && DialoguePortraits.any_visible?
                DialoguePortraits.hide_all
            end
            super
        end
    end

    module BattleHook
        private

        def pbBattleAnimation(*args, &block)
            DialoguePortraits.suspend
            begin
                return super
            ensure
                DialoguePortraits.resume
            end
        end
    end

    module GameHook
        def start_new(*args, &block)
            DialoguePortraits.reset
            super
        end

        def load(*args, &block)
            DialoguePortraits.reset
            super
        end
    end
end

Interpreter.prepend(DialoguePortraits::InterpreterHook)
Object.prepend(DialoguePortraits::BattleHook)
Game.singleton_class.prepend(DialoguePortraits::GameHook)
