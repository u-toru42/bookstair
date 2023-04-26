// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import HelloController from "./hello_controller"
application.register("hello", HelloController)

import ModalController from "./modal_controller"
application.register("modal", ModalController)

// app/javascript/controllers/index.js

import { Application } from "@hotwired/stimulus"
import ButtonController from "./books_controller"

const app = Application.start()
app.register("button", ButtonController)

