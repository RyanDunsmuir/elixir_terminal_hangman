defmodule Dictionary do
  @easy_words [
    "KIND",
    "MASK",
    "TUBA",
    "LOOP",
    "POLE",
    "FROG",
    "DUMP",
    "EAST",
    "WEST",
    "FIRE",
    "CAPE",
    "GOAL",
    "BUMP",
    "PUMP",
    "TAPE",
    "HOARD",
    "FLOOD"
  ]
  @medium_words [
    "devastate",
    "evolved",
    "plantain",
    "counterpart",
    "stranger",
    "agreeably",
    "JOURNEY",
    "ABRASIVE",
    "COARSE",
    "FEMININE",
    "MASCULINE",
    "IMPATIENT",
    "SCREAMS",
    "HAPPINESS",
    "PARENTHOOD"
  ]
  @hard_words [
    "DIFFICULT",
    "underclothing",
    "forbearant",
    "consequence",
    "mistakingly",
    "traditionally",
    "copiousness",
    "anthropical",
    "grapplement",
    "instableness",
    "abstractedness",
    "hydraulics",
    "circumflexion",
    "discombobulate",
    "infatuation",
    "antiperspirant",
    "disconfirmatory",
    "pessimistically"
  ]

  def random_word(:easy) do
    Enum.random(@easy_words)
    |> String.upcase()
  end

  def random_word(:medium) do
    Enum.random(@medium_words)
    |> String.upcase()
  end

  def random_word(:hard) do
    Enum.random(@hard_words)
    |> String.upcase()
  end
end
