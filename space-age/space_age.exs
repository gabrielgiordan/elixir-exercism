defmodule SpaceAge do
  @type planet ::
          :mercury
          | :venus
          | :earth
          | :mars
          | :jupiter
          | :saturn
          | :uranus
          | :neptune

  @doc """
  Return the number of years a person that has lived for 'seconds' seconds is
  aged on 'planet'.
  """
  @orbit_period %{
    mercury: 7600543.81992,
    venus: 19414149.052176,
    earth: 31557600,
    mars: 59354032.69008,
    jupiter: 374355659.124,
    saturn: 929292362.8848,
    uranus: 2651370019.3296,
    neptune: 5200418560.032
  }
  @spec age_on(planet, pos_integer) :: float
  def age_on(planet, seconds), do: seconds / @orbit_period[planet]
end
