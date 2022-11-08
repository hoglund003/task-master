import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  connect() {
    // check time every minute
    setInterval(() => {
      var date = new Date();
      if (date.getHours() == 0 && date.getMinutes() == 1) { // reload if time == 00:01
        window.location.reload()
      }
    }, 1000 * 60)
  }
}