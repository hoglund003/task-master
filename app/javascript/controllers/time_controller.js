import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  connect() {
    // check time every minute
    setInterval(() => {
      var date = new Date();
      if (date.getHours() == 1 && date.getMinutes() == 1) { // reload if time == 01:01
        window.location.reload()
      }
    }, 1000 * 60)
  }
}