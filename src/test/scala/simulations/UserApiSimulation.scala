package simulations

import io.gatling.core.Predef._
import io.gatling.http.Predef._
import scala.concurrent.duration._

class UserApiSimulation extends Simulation {

  val httpProtocol = http.baseUrl("https://jsonplaceholder.typicode.com")

  val scn = scenario("API Load Test")
    .exec(http("Get Users")
      .get("/users")
      .check(status.is(200)))

  setUp(scn.inject(atOnceUsers(100))).protocols(httpProtocol)
}
