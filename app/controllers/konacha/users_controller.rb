module Konacha
  class UsersController < ActionController::Base

    def get_user
      user = {user: all_users.find { |i| i[:id] == params[:id].to_i }}
      render json: user
    end

    def users
      users = all_users
      page  = params[:page].present? ? params[:page].to_i : 1
      limit = params[:limit].present? ? params[:limit].to_i : 0
      _return = {}
      _return[:users]       = users[(limit*(page-1))..((limit == 0 ? users.count : (limit*page))-1)]
      _return[:limit]       = limit
      _return[:total_count] = users.count
      _return[:offset]      = limit * (page - 1)
      render json: _return
    end

    def all_users
      [
          {
              id: 1,
              name: "John",
              lastname: "Smith",
              email: "John@smith.com"
          },
          {
              id: 2,
              name: "Mattie",
              lastname: "Peil",
              email: "Mattie@Peil.com"
          },
          {
              id: 3,
              name: "Sandra",
              lastname: "Lister",
              email: "Sandra@Lister.com"
          },
          {
              id: 4,
              name: "Geneva",
              lastname: "Schmit",
              email: "Geneva@Schmit.com"
          },
          {
              id: 5,
              name: "Debra",
              lastname: "Luera",
              email: "Debra@Luera.com"
          },
          {
              id: 6,
              name: "Crystal",
              lastname: "Deemer",
              email: "Crystal@Deemer.com"
          },
          {
              id: 7,
              name: "Lillian",
              lastname: "Fane",
              email: "Lillian@Fane.com"
          },
          {
              id: 8,
              name: "Joanna",
              lastname: "Solis",
              email: "Joanna@Solis.com"
          },
          {
              id: 9,
              name: "Benjamin",
              lastname: "Merriam",
              email: "Benjamin@Merriam.com"
          },
          {
              id: 10,
              name: "Nelson",
              lastname: "Gudino",
              email: "Nelson@Gudino.com"
          },
          {
              id: 11,
              name: "Adam",
              lastname: "Bigelow",
              email: "Adam@Bigelow.com"
          },
          {
              id: 12,
              name: "Joel",
              lastname: "Gauna",
              email: "Joel@Gauna.com"
          },
          {
              id: 13,
              name: "Lister",
              lastname: "Sandra",
              email: "Lister@Sandra.com"
          },
          {
              id: 14,
              name: "Schmit",
              lastname: "Geneva",
              email: "Schmit@Geneva.com"
          },
          {
              id: 15,
              name: "Luera",
              lastname: "Debra",
              email: "Luera@Debra.com"
          },
          {
              id: 16,
              name: "Deemer",
              lastname: "Crystal",
              email: "Deemer@Crystal.com"
          },
          {
              id: 17,
              name: "Fane",
              lastname: "Lillian",
              email: "Fane@Lillian.com"
          },
          {
              id: 18,
              name: "Solis",
              lastname: "Joanna",
              email: "Solis@Joanna.com"
          },
          {
              id: 19,
              name: "Merriam",
              lastname: "Benjamin",
              email: "Merriam@Benjamin.com"
          },
          {
              id: 20,
              name: "Gudino",
              lastname: "Nelson",
              email: "Gudino@Nelson.com"
          },
          {
              id: 21,
              name: "Dominykas",
              lastname: "Eustace",
              email: "Dominykas@Eustace.com"
          },
          {
              id: 22,
              name: "Benedetto",
              lastname: "Bahman",
              email: "Benedetto@Bahman.com"
          },
          {
              id: 23,
              name: "Daniel",
              lastname: "Sundara",
              email: "Daniel@Sundara.com"
          },
          {
              id: 24,
              name: "Watse",
              lastname: "Osborne",
              email: "Watse@Osborne.com"
          },
          {
              id: 25,
              name: "Gus",
              lastname: "Octavian",
              email: "Gus@Octavian.com"
          },
          {
              id: 26,
              name: "Varnava",
              lastname: "Kyrylo",
              email: "Varnava@Kyrylo.com"
          },
          {
              id: 27,
              name: "Yannic",
              lastname: "Kimi",
              email: "Yannic@Kimi.com"
          },
          {
              id: 28,
              name: "Joakim",
              lastname: "Martin",
              email: "Joakim@Martin.com"
          },
          {
              id: 29,
              name: "Zlatan",
              lastname: "Bartholomew",
              email: "Zlatan@Bartholomew.com"
          },
          {
              id: 30,
              name: "Ivor",
              lastname: "Valko",
              email: "Ivor@Valko.com"
          }
      ]
    end
  end
end
