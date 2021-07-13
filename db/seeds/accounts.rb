Account.find_or_create_by(user: User.find_or_create_by(mobile_phone: '79823205166'),
                          number: '1',
                          bookmaker: Bookmaker.find_or_create_by(name: '1xСтавка', country: 'Russia'))