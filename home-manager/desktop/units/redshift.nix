{ ... }:

{
  services.redshift = {
    enable = true;
    latitude = "55.953";
    longitude = "-3.189";
    temperature = {
      day = 6500;
      night = 2500;
    };
  };
}
