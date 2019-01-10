import "./index.css"
import { Elm } from "./Main.elm"
import * as serviceWorker from "./serviceWorker"

const app = Elm.Main.init({
  language: window.localStorage.getItem("language")
})

app.ports.storeLanguage.subscribe(language =>
  window.localStorage.setItem("language", language)
)

// If you want your app to work offline and load faster, you can change
// unregister() to register() below. Note this comes with some pitfalls.
// Learn more about service workers: http://bit.ly/CRA-PWA
serviceWorker.unregister()
