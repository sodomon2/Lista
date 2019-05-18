#!/usr/bin/lua
--[[!
 @package   LDRPUI
 @filename  init.lua
 @version   1.0
 @autor     Diaz Urbaneja Victor Eduardo Diex <diaz.victor@openmailbox.org>
 @date      19.06.2018 16:50:56 -04
]]--

-- declaro mis variables globales

require('lib.middleclass') -- la libreria middleclass me da soporte a OOP

lgi = require('lgi') -- requiero esta libreria para que me permitira usar GTK

GObject = lgi.GObject -- parte de lgi

GLib = lgi.GLib -- para el treeview

Gtk = lgi.require('Gtk', '3.0') -- el objeto GTK

assert = lgi.assert
builder = Gtk.Builder()

assert(builder:add_from_file('vistas/main.ui'),"error al cargar el archivo") -- hago un debugger, si este archivo existe (true) enlaso el archivo ejemplo.ui, si no existe (false) imprimo un error
ui = builder.objects

-- declaro los objetos

local main_window = ui.main_window -- invoco la ventana con el id main_window
local about_window = ui.about_window -- invoco la ventana con el id about_window


local entrada       = builder:get_object('entrada')   -- invoco al boton con el id entrada
local salida        = builder:get_object('salida')    --invoco al boton con el id salida
local relog         = builder:get_object('relog')     -- invoco al boton con el id relog
local btn_about     = builder:get_object('btn_about') -- invoco al boton con el id btn_about
local btn_pause     = builder:get_object('btn_pause') -- invoco al boton con el id btn_siguiente
local btn_play      = builder:get_object('btn_play')  -- invoco al boton con el id btn_anterior

-- cierro la ventana cuando se presione boton cerrar (x)
function main_window:on_destroy()
  Gtk.main_quit()
end

ui.relog.label = os.date("%H:%M:%S")
GLib.timeout_add_seconds(
    GLib.PRIORITY_DEFAULT, 1,
   function()
        ui.relog.label = os.date("%H:%M:%S")
    return true
end
)

function btn_about:on_clicked()
	about_window:run()
	about_window:hide()
end

function btn_play:on_clicked()
	os.execute("mpv")
end
-- inicio la ventana y muestro todo
main_window:show_all()
Gtk.main()