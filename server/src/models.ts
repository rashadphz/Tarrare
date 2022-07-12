interface User {
  firstName: string;
  lastName: string;
  email: string;
  emailVerified?: boolean;
  picture?: string;
  dateCreated: Date;
  lastLogin: Date;
  delivering: boolean;
  profile?: any; //TODO
  password: string;
}

interface Place {
    name: string
    fullAddress: string
    state: string
    city: string
    zipcode: number
    googlePlaceId: string
}

interface Profile {}

export { User, Profile, Place };
