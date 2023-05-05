-- import comment plugin safely
local setup, comment = pcall(require, "Comment")
if not setup then
	return
end

-- enable comment
comment.setup()

-- importing the todo-comments plugin
local setup1, todo = pcall(require, "todo-comments")
if not setup1 then
	return
end

-- enable todo-comments
todo.setup()
