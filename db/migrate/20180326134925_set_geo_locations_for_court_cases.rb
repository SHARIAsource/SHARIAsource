class SetGeoLocationsForCourtCases < ActiveRecord::Migration[5.1]
  def change
    docs = Document
           .joins(:document_type)
           .joins(:regions)
           .where(
             document_types: { name: 'Court Cases' },
             regions: { name: 'United States' }
           )

    united_states = Region.find_by(name: 'United States')

    states.each do |state_full, state_short|
      Region.create(name: state_full, parent: united_states)
      Region.create(name: state_short, parent: united_states)
    end

    docs.each do |doc|
      states.each do |state_full, state_short|
        if doc.authors.include?(state_full) || doc.title.include?(state_full) || doc.summary.include?(state_full)
          doc.regions << Region.find_by(name: state_full)
          doc.regions << Region.find_by(name: state_short)

          doc.save!

          break
        end
      end
    end
  end

  def states
    {
      'Alabama' => 'AL',
      'Alaska' => 'AK',
      'American Samoa' => 'AS',
      'Arizona' => 'AZ',
      'Arkansas' => 'AR',
      'California' => 'CA',
      'Colorado' => 'CO',
      'Connecticut' => 'CT',
      'Delaware' => 'DE',
      'District of Columbia' => 'DC',
      'Federated States Of Micronesia' => 'FM',
      'Florida' => 'FL',
      'Georgia' => 'GA',
      'Guam' => 'GU',
      'Hawaii' => 'HI',
      'Idaho' => 'ID',
      'Illinois' => 'IL',
      'Indiana' => 'IN',
      'Iowa' => 'IA',
      'Kansas' => 'KS',
      'Kentucky' => 'KY',
      'Louisiana' => 'LA',
      'Maine' => 'ME',
      'Marshall Islands' => 'MH',
      'Maryland' => 'MD',
      'Massachusetts' => 'MA',
      'Michigan' => 'MI',
      'Minnesota' => 'MN',
      'Mississippi' => 'MS',
      'Missouri' => 'MO',
      'Montana' => 'MT',
      'Nebraska' => 'NE',
      'Nevada' => 'NV',
      'New Hampshire' => 'NH',
      'New Jersey' => 'NJ',
      'New Mexico' => 'NM',
      'New York' => 'NY',
      'North Carolina' => 'NC',
      'North Dakota' => 'ND',
      'Northern Mariana Islands' => 'MP',
      'Ohio' => 'OH',
      'Oklahoma' => 'OK',
      'Oregon' => 'OR',
      'Palau' => 'PW',
      'Pennsylvania' => 'PA',
      'Puerto Rico' => 'PR',
      'Rhode Island' => 'RI',
      'South Carolina' => 'SC',
      'South Dakota' => 'SD',
      'Tennessee' => 'TN',
      'Texas' => 'TX',
      'Utah' => 'UT',
      'Vermont' => 'VT',
      'Virgin Islands' => 'VI',
      'Virginia' => 'VA',
      'Washington' => 'WA',
      'West Virginia' => 'WV',
      'Wisconsin' => 'WI',
      'Wyoming' => 'WY'
    }
  end
end
