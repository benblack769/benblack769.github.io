* Map
  * Continuous finite map, with borders
  * 1/(1+d^2) bump concentrations of food productivity spread over the map randomly
  * Starting people spread randomly
* Choices
  * Movement:
    * input:
      * direction
      * effort (translates to distance)
  * Combat:
    * input
      * direction
      * effort (effort translates to things like range and attack magnitude)
  * Gather food
    *
  * Take food
    * input:
      * Direction
      * Percent available food
    * Is accepted when:
      * person is in range
      * Person is unconscious/asleep
  * Give food:
    * Input:
      * Direction
      * Percent available food
* Basic stats:
  * Stamina:
    * deltas:
      * Movement/combat effort decreases stamina
      * Time increases stamina (in proportion to health)
      * Sleep/Unconsciousness accelerates stamina increase
  * Health:
    * state:
    * effects:
      * If health is below 20%, drop unconscious.
  * Mental stamina
    * deltas:
      * decreases over time
      * Sleep increases it
      * Unconsciousness keeps it the same
    * effects:
      * lower values lowers
* Identity stats
  *
