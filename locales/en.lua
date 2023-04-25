local Translations = {
    error = {
        ["trailer_not_found"] = "Trailer not found",
        ["cannot_attach"] = "You cannot attach this type of vehicle to this trailer",
        ["vehicle_not_found"] = "No attached vehicle found",
        ["not_in_vehicle"] = "You are not in a vehicle"
    },
    task = {
        ["attach"] = "[E] To Attach",
        ["detach"] = "[E] To Detach"
    }
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
