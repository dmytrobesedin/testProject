//
//  ViewController.swift
//  testProject
//
//  Created by Дмитрий Беседин on 15.02.2022.
//

import UIKit

final class DeviceListView: UIViewController {
	// MARK: - UI
	private lazy var devicesListTableView: UITableView = {
		let tableview = UITableView(frame: UIScreen.main.bounds, style: .plain)
		tableview.register(LightTableViewCell.self, forCellReuseIdentifier: LightTableViewCell.lightIdentifier)
		tableview.register(HeaterTableViewCell.self, forCellReuseIdentifier: HeaterTableViewCell.heaterIdentifier)
		tableview.register(RollerShutterTableViewCell.self, forCellReuseIdentifier: RollerShutterTableViewCell.rollerShutterIdentifier)
		tableview.dataSource = self
		tableview.delegate = self
		return tableview
	}()

	// MARK: - Private properties
	private var devicesViewModel: DevicesViewModel
	private var isSelectedRow = false
	private var selectedIndexPath = IndexPath(row: 0, section: 0)

	// MARK: - Init
	init(devicesViewModel: DevicesViewModel) {
		self.devicesViewModel = devicesViewModel
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Memory Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		setup()

		// subscribe delegate
		devicesViewModel.devicesViewModelDelegate = self

		// load  data
		loadDataFromViewModel()

		// delete items from UserDefaults
		devicesViewModel.userDefaultManager?.cleanUserDefaults()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		updateSelectedRow(isSelectedRow)
	}

	// MARK: - Private methods
	private func updateSelectedRow(_ isSelected: Bool)  {
		if isSelected {
			devicesViewModel.updateDataInUserDefaults()
		}
	}

	private func loadDataFromViewModel() {
		self.devicesViewModel.connectDevicesViewModelToController = { [weak self] in
			guard let self = self else { return }
			DispatchQueue.main.async{
				self.devicesListTableView.reloadData()
			}
		}
	}

	private func configureCell(_ device: Device,_ indexPath: IndexPath, _ tableView: UITableView) -> UITableViewCell? {
		switch device.productType {
		case .light:
			guard let lightDevice = device as? Light else { return nil }
			guard let lightCell = tableView.dequeueReusableCell(withIdentifier: LightTableViewCell.lightIdentifier, for: indexPath) as? LightTableViewCell else { return nil }
			let lightViewModel = LightViewModel(device: lightDevice)
			lightCell.configureCell(lightViewModel: lightViewModel)
			return lightCell

		case .heater:
			guard let heaterDevice = device as? Heater else { return nil }
			guard let heaterCell = tableView.dequeueReusableCell(withIdentifier: HeaterTableViewCell.heaterIdentifier, for: indexPath) as? HeaterTableViewCell else { return nil }
			let heaterViewModel = HeaterViewModel(device: heaterDevice)
			heaterCell.configureCell(heaterViewModel: heaterViewModel)
			return heaterCell

		case .rollerShutter:
			guard let rollerShutterDevice = device as? RollerShutter else { return nil }
			guard let rollerShutterCell = tableView.dequeueReusableCell(withIdentifier: RollerShutterTableViewCell.rollerShutterIdentifier, for: indexPath) as? RollerShutterTableViewCell else { return nil }
			let rollerShutterViewModel = RollerShutterViewModel(device: rollerShutterDevice)
			rollerShutterCell.configureCell(rollerShutterViewModel:rollerShutterViewModel)
			return rollerShutterCell
		}
	}
}

// MARK: - Setup Methods
private extension DeviceListView {
	func setup() {
		setupInterface()
		setupConstraints()
	}

	func setupInterface() {
		view.addSubview(devicesListTableView)
	}

	func setupConstraints() {
		NSLayoutConstraint.activate([
			// DevicesListTableView
			devicesListTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			devicesListTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			devicesListTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
	}
}

// MARK: - UITableViewDataSource
extension DeviceListView: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return devicesViewModel.deviceData?.devices.count ?? 0
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let device = devicesViewModel.deviceData?.devices[indexPath.row] else { return UITableViewCell() }
		guard let configureCell = configureCell(device, indexPath, tableView) else { return UITableViewCell() }
		return configureCell
	}
}

// MARK: - UITableViewDelegate
extension DeviceListView: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		isSelectedRow = true
		selectedIndexPath = indexPath
		guard let device = devicesViewModel.deviceData?.devices[indexPath.row] else { return }
		devicesViewModel.configureVC(device)
	}
}

// MARK: - DevicesViewModelDelegate
extension DeviceListView: DevicesViewModelDelegate {
	func didFinishConfiguringVC(_ vc: UIViewController) {
		navigationController?.pushViewController(vc, animated: true)
	}

	func didFinishUpdatingData() {
		DispatchQueue.main.async {
			self.devicesListTableView.reloadRows(at: [self.selectedIndexPath], with: .none)
		}
		isSelectedRow = false
	}
}

