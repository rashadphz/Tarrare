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
}

interface Profile {}

export { User, Profile };
