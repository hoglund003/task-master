import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  connect() {
    setInterval(() => {
      var date = new Date()
      if (date.getHours() == 0) {
        console.log("reload")
        window.location.reload()
      }
    }, 1000 * 60 * 60)
  }
}