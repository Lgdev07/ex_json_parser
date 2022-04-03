import "phoenix_html"
import {Socket} from "phoenix"
import {LiveSocket} from "phoenix_live_view"
import topbar from "../vendor/topbar"

let Hooks = {}

Hooks.CopyToClipboard = {
    mounted() {
      this.el.addEventListener("click", (e) => {
        const textArea = e.target.parentElement.getElementsByTagName("textarea")[0]
        textArea.select();
        textArea.setSelectionRange(0, 99999);
        navigator.clipboard.writeText(textArea.value);
        document.getElementById("toast-success").classList.remove("hidden");
        e.preventDefault()
      })
    }
  }

Hooks.CloseToast = {
    mounted() {
      this.el.addEventListener("click", (e) => {
        document.getElementById("toast-success").classList.add("hidden");
        e.preventDefault()
      })
    }
  }
  
let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let liveSocket = new LiveSocket("/live", Socket, {hooks: Hooks, params: {_csrf_token: csrfToken}})

topbar.config({barColors: {0: "#29d"}, shadowColor: "rgba(0, 0, 0, .3)"})
window.addEventListener("phx:page-loading-start", info => topbar.show())
window.addEventListener("phx:page-loading-stop", info => topbar.hide())

liveSocket.connect()

window.liveSocket = liveSocket
