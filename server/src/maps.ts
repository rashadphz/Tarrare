import { Place } from "@prisma/client";
import axios from "axios";
import dotenv from "dotenv";
import { context } from "./context";

dotenv.config();

let apiKey = process.env.GOOGLE_PLACES_API_KEY;

const setAddressComponents = (
  place: Place,
  addressComponents: any
) => {
  for (let i in addressComponents) {
    let component = addressComponents[i];
    let type = component["types"][0];
    let componentName = component["long_name"];

    if (type == "locality") {
      place.city = componentName;
    } else if (type == "street_number") {
      place.streetAddress += componentName + " ";
    } else if (type == "route") {
      place.streetAddress += componentName;
    } else if (type == "administrative_area_level_1") {
      place.state = componentName;
    } else if (type == "postal_code") {
      place.zipcode = parseInt(componentName);
    }
  }

  return place;
};

const placeFromGMSPlace = (gmsPlace: any) => {
  let basicPlace: Place = {
    id: 0,
    name: gmsPlace["name"],
    fullAddress: gmsPlace["formatted_address"],
    streetAddress: "",
    state: "",
    city: "",
    zipcode: 0,
    googlePlaceId: gmsPlace["place_id"],
  };
  let place: Place = setAddressComponents(
    basicPlace,
    gmsPlace["address_components"]
  );
  return place;
};

const placeFromId = async (placeId: string) => {
  // Return place if it already is in the database
  let existingPlace = await context.db.getPlaceFromGooglePlaceId(
    placeId
  );
  if (existingPlace) return existingPlace;

  let basicFields = [
    "address_component",
    "adr_address",
    "business_status",
    "formatted_address",
    "geometry",
    "icon",
    "icon_mask_base_uri",
    "icon_background_color",
    "name",
    "permanently_closed",
    "photo",
    "place_id",
    "plus_code",
    "type",
    "url",
    "utc_offset",
    "vicinity",
  ];
  let fieldsQueryString = basicFields.join("%2C"); //url space character
  var config = {
    method: "get",
    url: `https://maps.googleapis.com/maps/api/place/details/json?place_id=${placeId}&fields=${fieldsQueryString}&key=${apiKey}`,
    headers: {},
  };

  let response = await axios(config);
  let gmsPlace = response.data["result"];
  let place: Place = placeFromGMSPlace(gmsPlace);

  let createdPlace = await context.db.createPlace(place);
  return createdPlace;
};

const findNearbyResturants = async (
  longitude: string,
  latitude: string,
  radius: number = 800
) => {
  let keyword = "food";
  var config = {
    method: "get",
    url: `https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${longitude}%2C${latitude}&radius=${radius}&keyword=${keyword}&key=${apiKey}`,
    headers: {},
  };
  let response = await axios(config);
  let results: [any] = response.data["results"];

  let places = results
    .slice(0, 10)
    .map((result) => placeFromId(result["place_id"]));
  return places;
};

const maps = {
  findNearbyResturants,
};

export default maps;
