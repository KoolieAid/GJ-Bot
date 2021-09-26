local invite = {}

function invite:exec(message)

    local mentionedUsers = message.mentionedUsers

    if not (#mentionedUsers > 0) then replyToMessage(message, "No users specified"); return end

    local roleId = nil

    for k, v in pairs(commands.createTeam.teams) do
        if message.member:hasRole(v) then
            roleId = v
            break;
        end
    end

    if roleId == nil then replyToMessage(message, "You don't have a team") return end

    message.mentionedUsers:forEach(function(user)
        local member = message.guild:getMember(user.id)
        member:addRole(roleId)
    end)

    replyToMessage(message, "Users are now in your team")
end

return setmetatable(invite, {__index = self})