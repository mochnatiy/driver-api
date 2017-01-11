class Distance
  RAD_PER_DEG = 0.017453293

  Rkm = 6371 # radius in kilometers
  
  class << self
    def haversine_distance(lat1, lon1, lat2, lon2)
      dlon = lon2 - lon1
      dlat = lat2 - lat1

      dlon_rad = dlon * RAD_PER_DEG
      dlat_rad = dlat * RAD_PER_DEG

      lat1_rad = lat1 * RAD_PER_DEG
      lon1_rad = lon1 * RAD_PER_DEG

      lat2_rad = lat2 * RAD_PER_DEG
      lon2_rad = lon2 * RAD_PER_DEG

      a = (Math.sin(dlat_rad / 2)) ** 2 + Math.cos(lat1_rad) * Math.cos(lat2_rad) * (Math.sin(dlon_rad / 2)) ** 2
      
      c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a))

      dKm = Rkm * c # delta in kilometers
    end
    
    def pythagor_distance(lat1, lon1, lat2, lon2)
      Math.hypot(
        lat1 - lat2,
        lon1 - lon2
      )
    end
  end
end