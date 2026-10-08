import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:manawanui/core/providers/payee_providers.dart';
import 'package:manawanui/data/models/get_nz_addresses_response.dart';
import 'package:manawanui/data/models/get_nz_post_auth_token_response.dart';
import 'package:manawanui/helpers/extension/context_function.dart';
import 'package:manawanui/helpers/resources/api_param_keys.dart';
import 'package:manawanui/helpers/resources/colors.dart';
import 'package:manawanui/helpers/resources/strings.dart';
import 'package:manawanui/widgets/api_error_widget.dart';
import 'package:manawanui/widgets/custom_elevated_button.dart';
import 'package:manawanui/widgets/custom_text_field.dart';
import 'package:manawanui/widgets/text_view.dart';

class BottomSheetSearchModal {
  static void show(
      BuildContext context,
      String address,
      GetNZPostAuthTokenResponse? nzPostAuthTokenResponse,
      Function(String?) onSelect) {
    showModalBottomSheet(
      barrierLabel: "Search Address",
      barrierColor: Colors.black.withOpacity(0.5),
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: SearchAddressModal(address, nzPostAuthTokenResponse, onSelect),
        );
      },
    );
  }
}

class SearchAddressModal extends HookConsumerWidget {
  final String address;
  final GetNZPostAuthTokenResponse? nzPostAuthTokenResponse;
  final Function(String?) onSelect;

  const SearchAddressModal(
      this.address, this.nzPostAuthTokenResponse, this.onSelect,
      {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(nzSearchViewModelProvider);
    final searchAddressController = useTextEditingController();
    Timer? debounceTimer;

    useEffect(() {
      if (address.isNotEmpty) {
        searchAddressController.text = address;
        viewModel.getNzAddressesResponse(address, {
          ApiParamKeys.KEY_AUTHORIZATION:
              "Bearer ${nzPostAuthTokenResponse?.accessToken ?? ""}",
          ApiParamKeys.KEY_CLIENT_ID_NZ: StringResources.CLIENT_ID,
          'Accept': 'application/json',
        });
      }
      return null;
    }, []);

    void debounceTextEditing(Function(String) callback) {
      if (debounceTimer != null) {
        debounceTimer?.cancel();
      }

      debounceTimer = Timer(const Duration(milliseconds: 300), () {
        callback(searchAddressController.text);
      });
    }

    return Column(
      children: [
        const SizedBox(height: 32),
        Row(
          children: [
            const SizedBox(width: 16),
            GestureDetector(
              onTap: () {
                ref.invalidate(manuallyAddressPayeeProvider);
                context.pop();
              },
              child: const Icon(Icons.arrow_back_ios),
            ),
            const Expanded(
              child: TextView(
                text: "Search Address",
                textColor: Colors.black,
                align: TextAlign.center,
                textFontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
        const Divider(
          color: Colors.grey,
          height: 16,
        ),
        Row(
          children: [
            const SizedBox(width: 16),
            Expanded(
              child: CustomTextField(
                controller: searchAddressController,
                title: "Search Address",
                isContainBottomBorder: true,
                onChanged: (e) {
                  debounceTextEditing((p0) {
                    ref.watch(manuallyAddressPayeeProvider.notifier).state =
                        false;
                    viewModel.getNzAddressesResponse(p0, {
                      ApiParamKeys.KEY_AUTHORIZATION:
                          "Bearer ${nzPostAuthTokenResponse?.accessToken ?? ""}",
                      ApiParamKeys.KEY_CLIENT_ID_NZ: StringResources.CLIENT_ID,
                      'Accept': 'application/json',
                    });
                  });
                },
              ),
            ),
            const SizedBox(width: 16),
            TextButton(
              onPressed: () {
                context.pop();
              },
              child: const TextView(
                text: "Close",
                textColor: Colors.blue,
                textFontWeight: FontWeight.normal,
                fontSize: 16,
              ),
            )
          ],
        ),
        const SizedBox(height: 16),
        StreamBuilder<GetNZAddressResponse>(
          stream: viewModel.responseGetNZAddressStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const AddManuallyAddressWidget();
            } else if (snapshot.hasError) {
              return Center(
                  child: ApiErrorWidget(
                message: snapshot.error.toString(),
              ));
            } else if (snapshot.hasData) {
              final response = snapshot.data;
              final data = response;
              if (data?.addresses?.isNotEmpty == true) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: data?.addresses?.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () async {
                          ref
                              .watch(selectedAddressPayeeProvider.notifier)
                              .state = data?.addresses?[0].fullAddress;
                          context.pop();
                        },
                        title: TextView(
                          text: data?.addresses?[index].fullAddress ??
                              "Address 1",
                          textColor: Colors.black,
                          textFontWeight: FontWeight.normal,
                          fontSize: 14,
                        ),
                      );
                    },
                  ),
                );
              }
              return const AddManuallyAddressWidget();
            } else {
              return const AddManuallyAddressWidget();
            }
          },
        ),
      ],
    );
  }
}

class AddManuallyAddressWidget extends HookConsumerWidget {
  const AddManuallyAddressWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAddManuallyState = ref.watch(manuallyAddressPayeeProvider.notifier);
    final address1Controller = useTextEditingController();
    final address2Controller = useTextEditingController();
    final cityController = useTextEditingController();
    final postCodeController = useTextEditingController();
    return SizedBox(
      height: context.fullHeight(multiplier: 0.5),
      child: StreamBuilder<bool>(
          stream: isAddManuallyState.stream,
          builder: (context, snapshot) {
            if (snapshot.data == true) {
              return Container(
                margin: const EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  children: [
                    CustomTextField(
                        controller: address1Controller,
                        title: "Address 1",
                        onChanged: (e) {}),
                    CustomTextField(
                        controller: address2Controller,
                        title: "Address 2",
                        onChanged: (e) {}),
                    CustomTextField(
                        controller: cityController,
                        title: "City",
                        onChanged: (e) {}),
                    CustomTextField(
                        controller: postCodeController,
                        title: "Postcode",
                        onChanged: (e) {}),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomElevatedButton(
                        title: "Save",
                        backgroundColor: AppColors.primaryColor,
                        onPressed: () {
                          if (address1Controller.text.isEmpty) {
                            context.showErrorDialog(
                                "Address 1 is required field. Please fill it first before proceeding",
                                title: "Warning!");
                          } else if (cityController.text.isEmpty) {
                            context.showErrorDialog(
                                "City is required field. Please fill it first before proceeding",
                                title: "Warning!");
                          } else if (postCodeController.text.isEmpty) {
                            context.showErrorDialog(
                                "Postcode is required field. Please fill it first before proceeding",
                                title: "Warning!");
                          }
                          if (address1Controller.text.isNotEmpty &&
                              cityController.text.isNotEmpty &&
                              postCodeController.text.isNotEmpty) {
                            String address = "${address1Controller.text} "
                                "${address2Controller.text} "
                                "${cityController.text} "
                                "${postCodeController.text}";
                            ref
                                .watch(selectedAddressPayeeProvider.notifier)
                                .state = address.trim();
                            context.pop();
                          }
                        })
                  ],
                ),
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const TextView(
                    text: "No Address Found",
                    textColor: Colors.black,
                    textFontWeight: FontWeight.normal,
                    fontSize: 12),
                const SizedBox(
                  height: 4,
                ),
                TextButton(
                    onPressed: () {
                      ref.watch(manuallyAddressPayeeProvider.notifier).state =
                          true;
                    },
                    child: TextView(
                        text: "Add Manually",
                        textColor: AppColors.primaryColor,
                        textFontWeight: FontWeight.normal,
                        fontSize: 18))
              ],
            );
          }),
    );
  }
}

/*class BottomSheetSearchModal {
  static void show(BuildContext context,
      String address,
      GetNZPostAuthTokenResponse? nzPostAuthTokenResponse,
      Function(String?) onSelect,) {
    showModalBottomSheet(
        barrierLabel: "Search Address",
        barrierColor: Colors.black.withOpacity(0.5),
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.only(top: 16, bottom: 16),
              child: HookConsumer(
                builder: (context, ref, child) {
                  final viewModel = ref.watch(nzSearchViewModelProvider);
                  final searchAddressController = useTextEditingController();
                  Timer? debounceTimer;
                  useEffect(() {
                    if (address.isNotEmpty) {
                      searchAddressController.text = address;
                      viewModel.getNzAddressesResponse(address, {
                        ApiParamKeys.KEY_AUTHORIZATION:
                        "Bearer ${nzPostAuthTokenResponse?.accessToken ?? ""}",
                        ApiParamKeys.KEY_CLIENT_ID_NZ:
                        StringResources.CLIENT_ID,
                        'Accept': 'application/json'
                      });
                    }
                    return null;
                  }, []);

                  void debounceTextEditing(Function(String) callback) {
                    if (debounceTimer != null) {
                      debounceTimer?.cancel();
                    }

                    debounceTimer =
                        Timer(const Duration(milliseconds: 300), () {
                          callback(searchAddressController.text);
                        });
                  }

                  return Column(
                    children: [
                      const SizedBox(
                        height: 32,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 16,
                          ),
                          GestureDetector(
                              onTap: () {
                                context.pop();
                              },
                              child: const Icon(Icons.arrow_back_ios)),
                          const Expanded(
                            child: TextView(
                                text: "Search Address",
                                textColor: Colors.black,
                                align: TextAlign.center,
                                textFontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ],
                      ),
                      const Divider(
                        color: Colors.grey,
                        height: 16,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: CustomTextField(
                                controller: searchAddressController,
                                title: "Search Address",
                                isContainBottomBorder: true,
                                onChanged: (e) {
                                  debounceTextEditing((p0) =>
                                  {
                                    ref.watch(manuallyAddressPayeeProvider.notifier).state = false,
                                    viewModel.getNzAddressesResponse(p0, {
                                      ApiParamKeys.KEY_AUTHORIZATION:
                                      "Bearer ${nzPostAuthTokenResponse
                                          ?.accessToken ?? ""}",
                                      ApiParamKeys.KEY_CLIENT_ID_NZ:
                                      StringResources.CLIENT_ID,
                                      'Accept': 'application/json'
                                    }),
                                  });
                                }),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          TextButton(
                              onPressed: () {
                                context.pop();
                              },
                              child: const TextView(
                                  text: "Close",
                                  textColor: Colors.blue,
                                  textFontWeight: FontWeight.normal,
                                  fontSize: 16))
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      StreamBuilder<GetNZAddressResponse>(
                        stream: viewModel.responseGetNZAddressStream,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const AddManuallyAddressWidget();
                          } else if (snapshot.hasError) {
                            return Center(
                                child: ApiErrorWidget(
                                    message: snapshot.error.toString()));
                          } else if (snapshot.hasData) {
                            final response = snapshot.data;
                            final data = response;
                            if (data?.addresses?.isNotEmpty == true) {
                              return Expanded(
                                child: ListView.builder(
                                  itemCount: data?.addresses?.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                        onTap: () async {
                                          ref.watch(selectedAddressPayeeProvider.notifier).state = data?.addresses?[0].fullAddress;
                                          context.pop();
                                        },
                                        title: TextView(
                                            text: data?.addresses?[index]
                                                .fullAddress ??
                                                "Address 1",
                                            textColor: Colors.black,
                                            textFontWeight: FontWeight.normal,
                                            fontSize: 14));
                                  },
                                ),
                              );
                            }
                            return const AddManuallyAddressWidget();
                          } else {
                            return const AddManuallyAddressWidget();
                          }
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          );
        });
  }
}*/
