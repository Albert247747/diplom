import 'package:diplom/ui/common/theme/colors.dart';
import 'package:diplom/ui/common/theme/style_text.dart';
import 'package:diplom/ui/common/widgets/button/button.dart';
import 'package:diplom/utils/translations.g.dart';
import 'package:flutter/material.dart';

class RegistrationStepper extends StatefulWidget {
  const RegistrationStepper({required this.onComplete, super.key});

  final VoidCallback onComplete;

  @override
  State<RegistrationStepper> createState() => _RegistrationStepperState();
}

class _RegistrationStepperState extends State<RegistrationStepper> {
  final PageController _pageController = PageController();
  int _currentStep = 0;

  static const int _stepsCount = 3;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNextPressed() {
    if (_currentStep == _stepsCount - 1) {
      widget.onComplete();
      return;
    }

    _pageController.nextPage(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final steps = [
      _RegistrationStepData(
        icon: Icons.person_outline,
        title: context.t.mobile.registrationStepper.stepOneTitle,
        description: context.t.mobile.registrationStepper.stepOneDescription,
      ),
      _RegistrationStepData(
        icon: Icons.verified_user_outlined,
        title: context.t.mobile.registrationStepper.stepTwoTitle,
        description: context.t.mobile.registrationStepper.stepTwoDescription,
      ),
      _RegistrationStepData(
        icon: Icons.event_available_outlined,
        title: context.t.mobile.registrationStepper.stepThreeTitle,
        description: context.t.mobile.registrationStepper.stepThreeDescription,
      ),
    ];

    return Scaffold(
      backgroundColor: mainBackground,
      appBar: AppBar(
        backgroundColor: mainBackground,
        centerTitle: true,
        title: Text(
          context.t.mobile.registrationStepper.title,
          style: context.bodyMedium.copyWith(fontWeight: FontWeight.w600),
        ),
        actions: [
          TextButton(
            onPressed: widget.onComplete,
            child: Text(
              context.t.mobile.registrationStepper.skip,
              style: context.titleSmall.copyWith(color: mainGreen),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
          child: Column(
            children: [
              _StepProgressIndicator(
                currentStep: _currentStep,
                stepsCount: _stepsCount,
              ),
              const SizedBox(height: 40),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: steps.length,
                  onPageChanged: (index) {
                    setState(() => _currentStep = index);
                  },
                  itemBuilder: (context, index) {
                    return _RegistrationStep(step: steps[index]);
                  },
                ),
              ),
              const SizedBox(height: 24),
              BaseButton(
                borderRadius: BorderRadius.circular(60),
                backgroundColor: greenButtonMain,
                onPressed: _onNextPressed,
                width: double.infinity,
                height: 60,
                child: Text(
                  _currentStep == _stepsCount - 1
                      ? context.t.mobile.registrationStepper.start
                      : context.t.mobile.registrationStepper.next,
                  style: context.bodyMedium.copyWith(color: whiteColor),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StepProgressIndicator extends StatelessWidget {
  const _StepProgressIndicator({
    required this.currentStep,
    required this.stepsCount,
  });

  final int currentStep;
  final int stepsCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(stepsCount, (index) {
        final isActive = index <= currentStep;
        final isLast = index == stepsCount - 1;

        return Expanded(
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: isActive ? mainGreen : backgroundTextField,
                  shape: BoxShape.circle,
                  border: Border.all(color: isActive ? mainGreen : greyText),
                ),
                alignment: Alignment.center,
                child: Text(
                  '${index + 1}',
                  style: context.titleSmall.copyWith(
                    color: isActive ? whiteColor : blackColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (!isLast)
                Expanded(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    height: 2,
                    color: index < currentStep ? mainGreen : greyText,
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }
}

class _RegistrationStep extends StatelessWidget {
  const _RegistrationStep({required this.step});

  final _RegistrationStepData step;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: const BoxDecoration(
            color: mainGreen,
            shape: BoxShape.circle,
          ),
          child: Icon(step.icon, color: whiteColor, size: 56),
        ),
        const SizedBox(height: 32),
        Text(
          step.title,
          textAlign: TextAlign.center,
          style: context.titleMedium.copyWith(
            fontSize: 30,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          step.description,
          textAlign: TextAlign.center,
          style: context.bodyMedium.copyWith(color: greenText, height: 1.4),
        ),
      ],
    );
  }
}

class _RegistrationStepData {
  const _RegistrationStepData({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;
}
