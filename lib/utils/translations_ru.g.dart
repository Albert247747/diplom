///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

part of 'translations.g.dart';

// Path: <root>
typedef TranslationsRu = Translations; // ignore: unused_element
class Translations with BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.ru,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <ru>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations
	late final TranslationsSignInRu signIn = TranslationsSignInRu._(_root);
	late final TranslationsErrorRu error = TranslationsErrorRu._(_root);
	late final TranslationsDownloadMobileAppRu downloadMobileApp = TranslationsDownloadMobileAppRu._(_root);
	late final TranslationsWebRu web = TranslationsWebRu._(_root);
	late final TranslationsMobileRu mobile = TranslationsMobileRu._(_root);
	late final TranslationsValidationRu validation = TranslationsValidationRu._(_root);
}

// Path: signIn
class TranslationsSignInRu {
	TranslationsSignInRu._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ru: 'Вход'
	String get title => 'Вход';

	/// ru: 'Email'
	String get email => 'Email';

	/// ru: 'Password'
	String get password => 'Password';

	/// ru: 'показать'
	String get showText => 'показать';

	/// ru: 'Dashboard'
	String get dashboard => 'Dashboard';

	/// ru: 'Почта'
	String get emailHint => 'Почта';

	/// ru: 'Пароль'
	String get passwordHint => 'Пароль';
}

// Path: error
class TranslationsErrorRu {
	TranslationsErrorRu._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ru: 'Данная роль недоступна в веб-приложении.'
	String get workerInWebError => 'Данная роль недоступна в веб-приложении.';

	/// ru: 'Данная роль доступна только для сотрудников.'
	String get adminInWebError => 'Данная роль доступна только для сотрудников.';

	/// ru: 'Ошибка авторизации, попробуйте снова'
	String get authorizationError => 'Ошибка авторизации, попробуйте снова';

	/// ru: 'Ошибка авторизации, попробуйте снова'
	String get webAuthorizationError => 'Ошибка авторизации, попробуйте снова';

	/// ru: 'Данная роль не подходит для этой платформы'
	String get platformRoleError => 'Данная роль не подходит для этой платформы';

	/// ru: 'Данная роль не подходит для мобильного приложения'
	String get mobileRoleError => 'Данная роль не подходит для мобильного приложения';

	/// ru: 'Ошибка восстановления сессии'
	String get authRestoreError => 'Ошибка восстановления сессии';

	/// ru: 'Ошибка входа'
	String get loginError => 'Ошибка входа';

	/// ru: 'Ошибка при выходе'
	String get logoutError => 'Ошибка при выходе';

	/// ru: 'Пользователь не найден'
	String get userNotFound => 'Пользователь не найден';

	/// ru: 'Неверный пароль'
	String get wrongPassword => 'Неверный пароль';

	/// ru: 'Некорректный email'
	String get invalidEmail => 'Некорректный email';

	/// ru: 'Email уже используется'
	String get emailAlreadyInUse => 'Email уже используется';

	/// ru: 'Слишком слабый пароль'
	String get weakPassword => 'Слишком слабый пароль';

	/// ru: 'Нет интернета'
	String get networkRequestFailed => 'Нет интернета';

	/// ru: 'Ошибка авторизации'
	String get unknownAuthError => 'Ошибка авторизации';
}

// Path: downloadMobileApp
class TranslationsDownloadMobileAppRu {
	TranslationsDownloadMobileAppRu._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ru: 'Скачать мобильное приложение'
	String get downloadApp => 'Скачать мобильное приложение';
}

// Path: web
class TranslationsWebRu {
	TranslationsWebRu._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ru: 'Информация о сотруднике'
	String get userInfo => 'Информация о сотруднике';

	/// ru: 'Список сотрудников'
	String get listWorker => 'Список сотрудников';

	/// ru: 'Добавить нового сотрудника'
	String get addWorker => 'Добавить нового сотрудника';

	/// ru: 'Панель администратора'
	String get adminPanel => 'Панель администратора';

	/// ru: 'Создать сотрудника'
	String get createWorkerButton => 'Создать сотрудника';

	/// ru: 'Создать мероприятие'
	String get createEventButton => 'Создать мероприятие';

	/// ru: 'Список мероприятий'
	String get eventList => 'Список мероприятий';

	/// ru: 'Список мероприятий'
	String get workerList => 'Список мероприятий';

	/// ru: 'Данная роль недоступна в веб-приложении.'
	String get notAuthorizedMessage => 'Данная роль недоступна в веб-приложении.';

	/// ru: 'Пожалуйста войдите через мобильное приложение.'
	String get openMobileAppMessage => 'Пожалуйста войдите через мобильное приложение.';

	/// ru: 'Пожалуйста перейдите на сайт.'
	String get openWebSiteMessage => 'Пожалуйста перейдите на сайт.';

	/// ru: 'Назад'
	String get back => 'Назад';

	late final TranslationsWebCreateWorkerRu createWorker = TranslationsWebCreateWorkerRu._(_root);
	late final TranslationsWebCreateEventRu createEvent = TranslationsWebCreateEventRu._(_root);
}

// Path: mobile
class TranslationsMobileRu {
	TranslationsMobileRu._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ru: 'Смены'
	String get shifts => 'Смены';

	late final TranslationsMobileRegistrationStepperRu registrationStepper = TranslationsMobileRegistrationStepperRu._(_root);
	late final TranslationsMobileVacancyRu vacancy = TranslationsMobileVacancyRu._(_root);
}

// Path: validation
class TranslationsValidationRu {
	TranslationsValidationRu._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ru: 'Введите email'
	String get enterEmail => 'Введите email';

	/// ru: 'Некорректный формат email'
	String get invalidEmailFormat => 'Некорректный формат email';

	/// ru: 'Введите пароль'
	String get enterPassword => 'Введите пароль';

	/// ru: 'Пароль должен быть не менее 6 символов'
	String get minPasswordLength => 'Пароль должен быть не менее 6 символов';

	/// ru: 'Этот email уже зарегистрирован'
	String get emailAlreadyRegistered => 'Этот email уже зарегистрирован';

	/// ru: 'Пользователь с таким email не найден'
	String get userWithEmailNotFound => 'Пользователь с таким email не найден';

	/// ru: 'Слишком много попыток. Попробуйте позже'
	String get tooManyRequests => 'Слишком много попыток. Попробуйте позже';

	/// ru: 'Проверьте подключение к интернету'
	String get checkInternet => 'Проверьте подключение к интернету';

	/// ru: 'Ошибка'
	String get genericError => 'Ошибка';

	/// ru: 'Произошла неизвестная ошибка'
	String get unknownError => 'Произошла неизвестная ошибка';
}

// Path: web.createWorker
class TranslationsWebCreateWorkerRu {
	TranslationsWebCreateWorkerRu._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ru: 'Email'
	String get email => 'Email';

	/// ru: 'Password'
	String get password => 'Password';

	/// ru: 'Имя'
	String get name => 'Имя';

	/// ru: 'Фамилия'
	String get lastName => 'Фамилия';

	/// ru: 'Отчество'
	String get surname => 'Отчество';

	/// ru: 'Должность'
	String get role => 'Должность';

	/// ru: 'Сохранить'
	String get save => 'Сохранить';

	/// ru: 'Удалить'
	String get delete => 'Удалить';

	/// ru: 'Сотрудник успешно создан!'
	String get success => 'Сотрудник успешно создан!';

	/// ru: 'Ошибка, попробуйте еще раз'
	String get genericError => 'Ошибка, попробуйте еще раз';

	/// ru: 'Заполните все поля'
	String get fillAllFields => 'Заполните все поля';

	/// ru: 'Выберите роль'
	String get selectRole => 'Выберите роль';

	/// ru: 'Создать работника'
	String get submit => 'Создать работника';

	late final TranslationsWebCreateWorkerRolesRu roles = TranslationsWebCreateWorkerRolesRu._(_root);
}

// Path: web.createEvent
class TranslationsWebCreateEventRu {
	TranslationsWebCreateEventRu._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ru: 'Создание мероприятия'
	String get title => 'Создание мероприятия';

	/// ru: 'Новое мероприятие'
	String get formTitle => 'Новое мероприятие';

	/// ru: 'Название'
	String get name => 'Название';

	/// ru: 'Описание'
	String get description => 'Описание';

	/// ru: 'Место'
	String get location => 'Место';

	/// ru: 'Дата'
	String get date => 'Дата';

	/// ru: 'Начало'
	String get startTime => 'Начало';

	/// ru: 'Окончание'
	String get endTime => 'Окончание';

	/// ru: 'Количество сотрудников'
	String get workerCount => 'Количество сотрудников';

	/// ru: 'Оплата'
	String get salary => 'Оплата';

	/// ru: 'Выбрать дату'
	String get selectDate => 'Выбрать дату';

	/// ru: 'Выбрать время'
	String get selectTime => 'Выбрать время';

	/// ru: 'Создать мероприятие'
	String get submit => 'Создать мероприятие';

	/// ru: 'Мероприятие успешно создано!'
	String get success => 'Мероприятие успешно создано!';

	/// ru: 'Ошибка, попробуйте еще раз'
	String get genericError => 'Ошибка, попробуйте еще раз';

	/// ru: 'Заполните все поля'
	String get fillAllFields => 'Заполните все поля';

	/// ru: 'Количество сотрудников и оплата должны быть больше нуля'
	String get enterPositiveNumbers => 'Количество сотрудников и оплата должны быть больше нуля';

	/// ru: 'Время окончания должно быть позже времени начала'
	String get endTimeAfterStart => 'Время окончания должно быть позже времени начала';
}

// Path: mobile.registrationStepper
class TranslationsMobileRegistrationStepperRu {
	TranslationsMobileRegistrationStepperRu._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ru: 'Перед регистрацией'
	String get title => 'Перед регистрацией';

	/// ru: 'Заполните профиль'
	String get stepOneTitle => 'Заполните профиль';

	/// ru: 'Укажите email и пароль, чтобы получить доступ к мобильному приложению.'
	String get stepOneDescription => 'Укажите email и пароль, чтобы получить доступ к мобильному приложению.';

	/// ru: 'Дождитесь подтверждения'
	String get stepTwoTitle => 'Дождитесь подтверждения';

	/// ru: 'Администратор проверит данные сотрудника и назначит вашу роль.'
	String get stepTwoDescription => 'Администратор проверит данные сотрудника и назначит вашу роль.';

	/// ru: 'Выбирайте смены'
	String get stepThreeTitle => 'Выбирайте смены';

	/// ru: 'После входа бронируйте доступные смены и отслеживайте детали мероприятий.'
	String get stepThreeDescription => 'После входа бронируйте доступные смены и отслеживайте детали мероприятий.';

	/// ru: 'Далее'
	String get next => 'Далее';

	/// ru: 'Пропустить'
	String get skip => 'Пропустить';

	/// ru: 'Перейти к регистрации'
	String get start => 'Перейти к регистрации';
}

// Path: mobile.vacancy
class TranslationsMobileVacancyRu {
	TranslationsMobileVacancyRu._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ru: 'Должность'
	String get role => 'Должность';

	/// ru: 'Зп'
	String get salary => 'Зп';

	/// ru: 'Дата'
	String get date => 'Дата';

	/// ru: 'Время'
	String get time => 'Время';

	/// ru: 'мест'
	String get seats => 'мест';

	/// ru: 'Бронирование'
	String get booking => 'Бронирование';

	/// ru: 'Требования:'
	String get requirements => 'Требования:';

	/// ru: 'Комментарии:'
	String get comment => 'Комментарии:';

	/// ru: 'Забронировать'
	String get book => 'Забронировать';

	/// ru: 'Ваша смена забронирована'
	String get successShift => 'Ваша смена забронирована';

	/// ru: 'Ок'
	String get ok => 'Ок';

	/// ru: 'Профиль'
	String get profile => 'Профиль';

	/// ru: 'Должность:'
	String get post => 'Должность:';

	/// ru: 'Настройки'
	String get settings => 'Настройки';
}

// Path: web.createWorker.roles
class TranslationsWebCreateWorkerRolesRu {
	TranslationsWebCreateWorkerRolesRu._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ru: 'Бармен'
	String get bartender => 'Бармен';

	/// ru: 'Официант'
	String get waiter => 'Официант';

	/// ru: 'Повар'
	String get cook => 'Повар';
}

/// The flat map containing all translations for locale <ru>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'signIn.title' => 'Вход',
			'signIn.email' => 'Email',
			'signIn.password' => 'Password',
			'signIn.showText' => 'показать',
			'signIn.dashboard' => 'Dashboard',
			'signIn.emailHint' => 'Почта',
			'signIn.passwordHint' => 'Пароль',
			'error.workerInWebError' => 'Данная роль недоступна в веб-приложении.',
			'error.adminInWebError' => 'Данная роль доступна только для сотрудников.',
			'error.authorizationError' => 'Ошибка авторизации, попробуйте снова',
			'error.webAuthorizationError' => 'Ошибка авторизации, попробуйте снова',
			'error.platformRoleError' => 'Данная роль не подходит для этой платформы',
			'error.mobileRoleError' => 'Данная роль не подходит для мобильного приложения',
			'error.authRestoreError' => 'Ошибка восстановления сессии',
			'error.loginError' => 'Ошибка входа',
			'error.logoutError' => 'Ошибка при выходе',
			'error.userNotFound' => 'Пользователь не найден',
			'error.wrongPassword' => 'Неверный пароль',
			'error.invalidEmail' => 'Некорректный email',
			'error.emailAlreadyInUse' => 'Email уже используется',
			'error.weakPassword' => 'Слишком слабый пароль',
			'error.networkRequestFailed' => 'Нет интернета',
			'error.unknownAuthError' => 'Ошибка авторизации',
			'downloadMobileApp.downloadApp' => 'Скачать мобильное приложение',
			'web.userInfo' => 'Информация о сотруднике',
			'web.listWorker' => 'Список сотрудников',
			'web.addWorker' => 'Добавить нового сотрудника',
			'web.adminPanel' => 'Панель администратора',
			'web.createWorkerButton' => 'Создать сотрудника',
			'web.createEventButton' => 'Создать мероприятие',
			'web.eventList' => 'Список мероприятий',
			'web.workerList' => 'Список мероприятий',
			'web.notAuthorizedMessage' => 'Данная роль недоступна в веб-приложении.',
			'web.openMobileAppMessage' => 'Пожалуйста войдите через мобильное приложение.',
			'web.openWebSiteMessage' => 'Пожалуйста перейдите на сайт.',
			'web.back' => 'Назад',
			'web.createWorker.email' => 'Email',
			'web.createWorker.password' => 'Password',
			'web.createWorker.name' => 'Имя',
			'web.createWorker.lastName' => 'Фамилия',
			'web.createWorker.surname' => 'Отчество',
			'web.createWorker.role' => 'Должность',
			'web.createWorker.save' => 'Сохранить',
			'web.createWorker.delete' => 'Удалить',
			'web.createWorker.success' => 'Сотрудник успешно создан!',
			'web.createWorker.genericError' => 'Ошибка, попробуйте еще раз',
			'web.createWorker.fillAllFields' => 'Заполните все поля',
			'web.createWorker.selectRole' => 'Выберите роль',
			'web.createWorker.submit' => 'Создать работника',
			'web.createWorker.roles.bartender' => 'Бармен',
			'web.createWorker.roles.waiter' => 'Официант',
			'web.createWorker.roles.cook' => 'Повар',
			'web.createEvent.title' => 'Создание мероприятия',
			'web.createEvent.formTitle' => 'Новое мероприятие',
			'web.createEvent.name' => 'Название',
			'web.createEvent.description' => 'Описание',
			'web.createEvent.location' => 'Место',
			'web.createEvent.date' => 'Дата',
			'web.createEvent.startTime' => 'Начало',
			'web.createEvent.endTime' => 'Окончание',
			'web.createEvent.workerCount' => 'Количество сотрудников',
			'web.createEvent.salary' => 'Оплата',
			'web.createEvent.selectDate' => 'Выбрать дату',
			'web.createEvent.selectTime' => 'Выбрать время',
			'web.createEvent.submit' => 'Создать мероприятие',
			'web.createEvent.success' => 'Мероприятие успешно создано!',
			'web.createEvent.genericError' => 'Ошибка, попробуйте еще раз',
			'web.createEvent.fillAllFields' => 'Заполните все поля',
			'web.createEvent.enterPositiveNumbers' => 'Количество сотрудников и оплата должны быть больше нуля',
			'web.createEvent.endTimeAfterStart' => 'Время окончания должно быть позже времени начала',
			'mobile.shifts' => 'Смены',
			'mobile.registrationStepper.title' => 'Перед регистрацией',
			'mobile.registrationStepper.stepOneTitle' => 'Заполните профиль',
			'mobile.registrationStepper.stepOneDescription' => 'Укажите email и пароль, чтобы получить доступ к мобильному приложению.',
			'mobile.registrationStepper.stepTwoTitle' => 'Дождитесь подтверждения',
			'mobile.registrationStepper.stepTwoDescription' => 'Администратор проверит данные сотрудника и назначит вашу роль.',
			'mobile.registrationStepper.stepThreeTitle' => 'Выбирайте смены',
			'mobile.registrationStepper.stepThreeDescription' => 'После входа бронируйте доступные смены и отслеживайте детали мероприятий.',
			'mobile.registrationStepper.next' => 'Далее',
			'mobile.registrationStepper.skip' => 'Пропустить',
			'mobile.registrationStepper.start' => 'Перейти к регистрации',
			'mobile.vacancy.role' => 'Должность',
			'mobile.vacancy.salary' => 'Зп',
			'mobile.vacancy.date' => 'Дата',
			'mobile.vacancy.time' => 'Время',
			'mobile.vacancy.seats' => 'мест',
			'mobile.vacancy.booking' => 'Бронирование',
			'mobile.vacancy.requirements' => 'Требования:',
			'mobile.vacancy.comment' => 'Комментарии:',
			'mobile.vacancy.book' => 'Забронировать',
			'mobile.vacancy.successShift' => 'Ваша смена забронирована',
			'mobile.vacancy.ok' => 'Ок',
			'mobile.vacancy.profile' => 'Профиль',
			'mobile.vacancy.post' => 'Должность:',
			'mobile.vacancy.settings' => 'Настройки',
			'validation.enterEmail' => 'Введите email',
			'validation.invalidEmailFormat' => 'Некорректный формат email',
			'validation.enterPassword' => 'Введите пароль',
			'validation.minPasswordLength' => 'Пароль должен быть не менее 6 символов',
			'validation.emailAlreadyRegistered' => 'Этот email уже зарегистрирован',
			'validation.userWithEmailNotFound' => 'Пользователь с таким email не найден',
			'validation.tooManyRequests' => 'Слишком много попыток. Попробуйте позже',
			'validation.checkInternet' => 'Проверьте подключение к интернету',
			'validation.genericError' => 'Ошибка',
			'validation.unknownError' => 'Произошла неизвестная ошибка',
			_ => null,
		};
	}
}
