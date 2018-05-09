requires "Class::Method::Modifiers" => "0";
requires "Email::Stuffer" => "0";
requires "Mojo::UserAgent" => "0";
requires "Test::Most" => "0";
requires "strict" => "0";
requires "warnings" => "0";

on 'test' => sub {
  requires "Test::Builder::Tester" => "0";
  requires "Test::More" => "0";
};

on 'configure' => sub {
  requires "ExtUtils::MakeMaker" => "0";
};
