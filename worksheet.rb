########################################################
# Step 1: Establish the layers

# In this section of the file, as a series of comments,
# create a list of the layers you identify.
# Which layers are nested in each other?
# Which layers of data "have" within it a different layer?
# Which layers are "next" to each other?

#I notice three layers:
#1. The "table" of data that contains a series of rows.
#2. Individual rows, each representing a single "ride."
#3. The columns, which contain specific information about the rifr: the driver, the cost, the date, etc. 

########################################################
# Step 2: Assign a data structure to each layer

# Copy your list from above, and in this section
# determine what data structure each layer should have

#1. The "table" of data that contains a series of rows. - An array
#2. Individual rows, each representing a single "ride." - A hash
#3. The columns, which contain specific information about the rifr: the driver, the cost, the date, etc. - key/value pairs. 
########################################################
# Step 3: Make the data structure!

# Setup the entire data structure:
# based off of the notes you have above, create the
# and manually write in data presented in rides.csv
# You should be copying and pasting the literal data
# into this data structure, such as "DR0004"
# and "3rd Feb 2016" and "RD0022"

rides =  [{driver_id: "DR0004", date: "3rd Feb 2016", cost: 5, rider_id: "RD0022", rating: 5},
         {driver_id: "DR0001", date: "3rd Feb 2016", cost: 10, rider_id: "RD0003", rating: 3},
         {driver_id: "DR0002", date: "3rd Feb 2016", cost: 25, rider_id: "RD0073", rating: 5},
         {driver_id: "DR0001", date: "3rd Feb 2016", cost: 30, rider_id: "RD0015", rating: 4},
         {driver_id: "DR0003", date: "4th Feb 2016", cost: 5, rider_id: "RD0066", rating: 5},
         {driver_id: "DR0004", date: "4th Feb 2016", cost: 10, rider_id: "RD0022", rating: 4},
         {driver_id: "DR0002", date: "3rd Feb 2016", cost: 25, rider_id: "RD0073", rating: 5},
         {driver_id: "DR0002", date: "4th Feb 2016", cost: 15, rider_id: "RD0013", rating: 1},
         {driver_id: "DR0003", date: "5th Feb 2016", cost: 50, rider_id: "RD0003", rating: 5},
         {driver_id: "DR0002", date: "5th Feb 2016", cost: 35, rider_id: "RD0066", rating: 3},
         {driver_id: "DR0004", date: "5th Feb 2016", cost: 20, rider_id: "RD0073", rating: 5},
         {driver_id: "DR0001", date: "5th Feb 2016", cost: 45, rider_id: "RD0003", rating: 2}
]


########################################################
# Step 4: Total Driver's Earnings and Number of Rides

# Use an iteration blocks to print the following answers:
# - the number of rides each driver has given
# - the total amount of money each driver has made
# - the average rating for each driver
# - Which driver made the most money?
# - Which driver has the highest average rating?

def driver_ride_count(rides)
  ride_count = Hash.new{|hash, key| hash[key] = 0}

  rides.each do |ride|
    ride_count[ride[:driver_id]] += 1
  end

  return ride_count
end

def driver_earnings(rides)
  earnings = Hash.new{|hash, key| hash[key] = 0}

  rides.each do |ride|
    earnings[ride[:driver_id]] += ride[:cost]
  end

  return earnings
end

def driver_mean_ratings(rides)
  mean_ratings = Hash.new{|hash, key| hash[key] = []}

  rides.each do |ride|
    mean_ratings[ride[:driver_id]] << ride[:rating]
  end

  mean_ratings.each do |driver, ratings|
    mean_ratings[driver] = ratings.sum/ratings.length
  end

  return mean_ratings
end

def driver_max_earnings(rides)
  return driver_earnings(rides).max_by{ |driver, earnings| earnings}[0]
end

def driver_max_rating(rides)
  return driver_mean_ratings(rides).max_by{ |driver, rating| rating}[0]
end

def driver_best_payday(rides)
  best_paydays = {}
  best_payday_rows = rides.group_by{|ride| ride[:driver_id].to_sym}.map{|driver, row| row.max_by{|ride| ride[:cost]}}

  best_payday_rows.each do |row|
    best_paydays[row[:driver_id]] = row[:date]
  end

  return best_paydays
end

def output_driver_data(ride_counts, earnings, mean_ratings, best_paydays)
  return ride_counts.map{|driver, ride_count| "Driver #{driver} drove #{ride_count} times, made $#{earnings[driver]}, their avg rating is #{mean_ratings[driver]}, and their best payday was #{best_paydays[driver]}"}.sort
end

def output_driver_max_data(max_earnings, max_rating)
  return "Driver #{max_earnings} made the most money.\nDriver #{max_rating} had the highest average rating."
end

puts output_driver_data(driver_ride_count(rides), driver_earnings(rides), driver_mean_ratings(rides), driver_best_payday(rides))
puts output_driver_max_data(driver_max_earnings(rides), driver_max_rating(rides))
