main.lua layout.aly buju.aly xfc1.aly init.lua xfc.aly

require "import"
import "res/init"
import "res/lasm"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "layout"
import "andlua"

activity.setTheme(R.Theme_Blue)
activity.setTitle("本地密码")
activity.setContentView(loadlayout(layout))

隐藏标题栏()
沉浸状态栏()

function nm.onClick()
    if e.text=="54188" then
        MD提示("登录成功.正在跳转",0xFF2196F3,0xFFFFF
        跳转界面("mm")
        nm.text="登录成功"
    else
        nm.text="登录失败"
        MD提示("密码错误",0xFF2196F3,0xFFFFFFFF,4,1
    end
end

控件圆角(nm,0xFF00FFFF,80)
控件圆角(e,0xFF00FFFF,80)
