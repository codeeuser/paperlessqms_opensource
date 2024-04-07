// ignore_for_file: use_build_context_synchronously

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:call/logger.dart';
import 'package:call/screens/way_screen.dart';
import 'package:common/app_absorb.dart';
import 'package:common/bloc/agent_bloc.dart';
import 'package:common/bloc/token_bloc.dart';
import 'package:common/generated/l10n.dart';
import 'package:common/models/agent_model.dart';
import 'package:common/models/token_issued_model.dart';
import 'package:common/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectAgent extends StatefulWidget {
  final SharedPreferences prefs;
  final TokenIssuedModel issued;
  final AgentModel agent;
  const SelectAgent(
      {super.key,
      required this.prefs,
      required this.issued,
      required this.agent});

  @override
  State<SelectAgent> createState() => _SelectAgentState();
}

class _SelectAgentState extends State<SelectAgent> {
  static const String tag = 'SelectAgent';

  List<AgentModel>? _agentList;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    Logger.log(tag, message: '_initialize---');
    int? departmentId = widget.issued.departmentId;
    if (departmentId != null) {
      context.read<AgentBloc>().add(
          AgentLoadByDepartmentEvent(departmentId: departmentId, enable: true));
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    if (width > ScreenProp.widthPhoneScreenLimit) {
      width = ScreenProp.widthPhoneScreenLimit;
    }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(S.of(context).transferToken),
      ),
      body: BlocBuilder<TokenBloc, TokenState>(
        builder: (context, state) {
          if (state is TokenTransferedState){            
            Utils.pushAndRemoveUntilPage(context,
              WayScreen(prefs: widget.prefs, agent: widget.agent), 'WayScreen');
            return const SizedBox();
          }
          return Center(
            child: Container(
              alignment: Alignment.topCenter,
              width: width,
              child: SingleChildScrollView(
                child: BlocBuilder<AgentBloc, AgentState>(
                  builder: (context, state) {
                    if (state is AgentLoadedState) {
                      _agentList = state.agents;
                    }
                    return Column(
                      children: [
                        for (AgentModel agent in _agentList ?? []) ...[
                          _buildItem(agent),
                        ]
                      ],
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildItem(AgentModel agent) {
    TextStyle? styleDisable = Theme.of(context)
        .textTheme
        .bodySmall
        ?.apply(fontStyle: FontStyle.italic);
    if (agent.id == widget.agent.id) {
      return ListTile(
        leading: Container(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 12),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            border: Border.all(width: 1.0, color: Colors.white),
            borderRadius: const BorderRadius.all(Radius.circular(6)),
            color: Colors.grey,
          ),
          child: Text(S.of(context).owner.toUpperCase(),
              style: const TextStyle(color: Colors.white)),
        ),
        title: Text(agent.login ?? '', style: styleDisable),
        subtitle: Text(agent.email ?? '', style: styleDisable),
      );
    }
    return ListTile(
      title: Text(agent.login ?? ''),
      subtitle: Text(agent.email ?? ''),
      onTap: () async {
        AppAbsorb appAbsorb = context.read<AppAbsorb>();
        final token = widget.issued;
        Utils.statusTransfer(token, agent);
        OkCancelResult result = await Utils.updateTokenIssued(context, appAbsorb, agent, token);
        if (result == OkCancelResult.ok){
          Navigator.of(context).pop();
        }
      },
    );
  }
}
