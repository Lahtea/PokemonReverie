#===============================================================================
# Dialogue Portraits - commands for events
# Use these in an event's Script command (or from any Ruby code).
# Portrait names are file names in Graphics/Portraits/ (without the extension)
#
#   portraitLeft("TamarindNeutral")   Slide Tamarind in on the left.
#                                     If the left side already has a portrait,
#                                     the image is swapped in place instead.
#   portraitRight("ZainAngry")        The same, for the right side.
#   portraitHide(:left)               Slide the left portrait out.
#   portraitHide(:right)              Slide the right portrait out.
#   portraitHideAll                   Slide both portraits out.
#   portraitTalking(:left)            Mark who is talking: the other portrait
#                                     is dimmed. portraitTalking(:none) undims both.
#   portraitWait                      Wait until every slide has finished.
#
# Showing a portrait also makes that side the one talking.
# Slides don't stop the event: the next command runs while the portrait moves.
# Hide one side and show the other in a row to swap characters at the same time.
#
# Inside a Show Text message you can also use the text codes:
#   \pl[TamarindAngry]   Change (or show) the left portrait at that point in the text.
#   \pr[ZainNeutral]     The same, for the right side.
#   \pl[] or \pr[]       Slide that side's portrait out.
#===============================================================================

def portraitLeft(name)
    DialoguePortraits.show(:left, name)
    return true
end

def portraitRight(name)
    DialoguePortraits.show(:right, name)
    return true
end

def portraitHide(side)
    DialoguePortraits.hide(side)
    return true
end

def portraitHideAll
    DialoguePortraits.hide_all
    return true
end

def portraitTalking(side)
    DialoguePortraits.talking = side
    return true
end

def portraitWait
    while DialoguePortraits.sliding?
        Graphics.update
        Input.update
        pbUpdateSceneMap
    end
    return true
end
