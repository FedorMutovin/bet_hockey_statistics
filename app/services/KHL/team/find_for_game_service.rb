class KHL::Team::FindForGameService
  attr_accessor :id
  attr_reader :team_name

  EXTRA_CLUBS_IDS = Team.khl.where(name: ['Динамо Рига', 'Динамо Москва',
                                          'Динамо Минск', 'Куньлунь Ред Стар Пекин',
                                          'Металлург Магнитогорск'])
                        .pluck(:id).freeze

  KHL_TEAMS_NAMES_WITHOUT_EXTRA = Team.khl.where.not(name: EXTRA_CLUBS_IDS).pluck(:name, :id).to_h
  EXTRA_CLUBS_IDS_WITH_NAMES = { 'Динамо Р' => EXTRA_CLUBS_IDS[0],
                                 'Динамо М' => EXTRA_CLUBS_IDS[1],
                                 'Динамо Мн' => EXTRA_CLUBS_IDS[2],
                                 'Куньлунь РС' => EXTRA_CLUBS_IDS[3],
                                 'Металлург Мг' => EXTRA_CLUBS_IDS[4] }.freeze

  def initialize(team_name)
    @team_name = team_name
  end

  def call
    find_team_for_game
    self
  end

  private

  def find_team_for_game
    self.id = find_team_id
  end

  def find_team_id
    return EXTRA_CLUBS_IDS_WITH_NAMES[team_name] if EXTRA_CLUBS_IDS_WITH_NAMES[team_name].present?

    KHL_TEAMS_NAMES_WITHOUT_EXTRA.each do |name, id|
      return id if name.include?(team_name)
    end
  end
end
