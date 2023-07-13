
- 瞎写的配置
- 用gs来改变当前光标下的单词, 比如 true -> false

```
{
  "znycat/antonvim",
  event = "VeryLazy",
},
```

```
["gs"] = {
  function() require("antonvim").antonvim() end,
  desc = "antovim",
},
```
